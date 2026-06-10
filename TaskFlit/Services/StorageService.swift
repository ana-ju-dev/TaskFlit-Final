//
//  StorageService.swift
//  TaskFlit
//
//  Created by Ana Julia da Cunha Pereira on 06/06/26.
//

import Foundation

class StorageService {
    
    static func loadMockTasks() -> [TaskItem] {
        
        guard let url = Bundle.main.url(forResource: "tasks", withExtension: "json") else {
            print("❌ Erro Crítico: O Xcode esqueceu de embutir o arquivo tasks.json no app!")
            return []
        }
        
        print("📍 2. Arquivo encontrado no caminho: \(url)")
        
        do {
            let data = try Data(contentsOf: url)
            print("💾 3. Conseguimos ler os bytes do arquivo (Tamanho: \(data.count) bytes)")
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let tasks = try decoder.decode([TaskItem].self, from: data)
            print("🎉 4. Sucesso! Convertemos os bytes em \(tasks.count) objetos de tarefa.")
            return tasks
            
        } catch {
            print("💥 Erro de Sintaxe: O arquivo JSON foi achado, mas tem algum erro de digitação no texto dele! Detalhe: \(error)")
            return []
        }
    }
}
