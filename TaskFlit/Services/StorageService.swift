//
//  StorageService.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

struct StorageService {
    
    private static var fileURL: URL { //procuta o arquivo do IOS onde é permitido salver os arquivos
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent("user_tasks.json")
    }
    
    static func loadTasks() -> [TaskItem] {
        if FileManager.default.fileExists(atPath: fileURL.path) { //pra quando o app ja tiver sido usado
            print("lendo dados salvos no HD do aparelho")
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode([TaskItem].self, from: data)
            } catch {
                print("erro ao ler o arquivo do HD: \(error)")
            }
        }

        print("arquivo salvo não encontrado. Carregando dados iniciais de fábrica")
        guard let mockURL = Bundle.main.url(forResource: "tasks", withExtension: "json") else { //para quando for a primeira vez do usuario usando o app
            return []
        }
        
        do {
            let data = try Data(contentsOf: mockURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let factoryTasks = try decoder.decode([TaskItem].self, from: data)

            saveTasks(factoryTasks)
            return factoryTasks
        } catch {
            print("erro ao decodificar JSON de fábrica: \(error)")
            return []
        }
    }

    static func saveTasks(_ tasks: [TaskItem]) { //salva as modificacoes wue a viewmodel manda
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            encoder.outputFormatting = .prettyPrinted
            
            let data = try encoder.encode(tasks)
            try data.write(to: fileURL, options: [.atomic, .completeFileProtection])
            print("dados salvos com sucesso no HD do aparelho")

        } catch {
            print("ERRO DETALHADO:")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .keyNotFound(let key, _):
                    print("Chave não encontrada: \(key.stringValue)")
                case .typeMismatch(let type, let context):
                    print("Tipo incompatível: \(type). Contexto: \(context.debugDescription)")
                case .valueNotFound(let type, _):
                    print("Valor nulo inesperado para o tipo: \(type)")
                case .dataCorrupted(let context):
                    print("Dados corrompidos: \(context.debugDescription)")
                @unknown default:
                    print("Erro desconhecido: \(error)")
                }
            }
        }
    }
}
