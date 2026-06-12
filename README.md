# 📱 TaskFlit — Gerenciador de Tarefas Pessoal

O **TaskFlit** é um aplicativo nativo para o ecossistema iOS projetado para transformar a organização pessoal e diária em uma experiência fluida, limpa e minimalista. Focado em produtividade real e livre de distrações, o app combina uma interface intuitiva à uma engenharia de software robusta baseada em padrões oficiais da Apple.

---

## 🚀 Funcionalidades Principais

* **Gerenciamento Ágil de Tarefas:** Criação, conclusão e exclusão de afazeres de forma instantânea através de uma interface baseada em cards.
* **Controle Cronológico Inteligente:** Exibição clara e objetiva de datas e horários de vencimento diretamente no card da tarefa.
* **Filtros Dinâmicos e Busca em Tempo Real:** Segmentação rápida por abas (Todas, Pendentes, Concluídas) e barra de pesquisa inteligente com feedback textual para resultados não encontrados.
* **Central de Produtividade:** Uma seção exclusiva na tela de perfil que calcula e exibe, em tempo real, contadores visuais do progresso do usuário.
* **Edição Direta de Perfil:** Atualização de dados cadastrais (Nome, E-mail e Idade) direto no campo de texto, com botões contextuais de salvamento e validação de formato de e-mail.

---

## 🛠️ Tecnologias e Arquitetura

O projeto foi construído seguindo as melhores práticas de desenvolvimento iOS moderno:

* **Linguagem:** Swift
* **Framework de Interface:** SwiftUI (Layouts reativos, componentes nativos e suporte a Dark Mode)
* **Arquitetura:** MVVM (Model-View-ViewModel) para uma separação clara de responsabilidades, testabilidade e código limpo.
* **Persistência de Dados:** 100% local e segura utilizando `UserDefaults` através de uma camada de serviço dedicada (`StorageService`), garantindo privacidade e carregamento instantâneo.
* **Ciclo de Vida:** Gerenciamento assíncrono de estados nativos (`@State`, `@Binding`) e atualização de contadores orientada a eventos de tela (`onAppear`).

---

## 📂 Estrutura do Projeto

O código está organizado seguindo fielmente o padrão de arquitetura de pastas do ecossistema:

* `App/`: Ponto de entrada do aplicativo (`TaskFlitApp.swift`).
* `Models/`: Definições das estruturas de dados (`TaskItem.swift`, `UserProfile.swift`).
* `ViewModels/`: Lógica de negócios e pontes de comunicação com a interface (`TaskViewModel.swift`, `ProfileViewModel.swift`).
* `Views/`: Componentes visuais isolados e telas principais divididas por módulos (`Tasks/`, `Profile/`, `Main/`, `Splash/`).
* `Services/`: Camada de infraestrutura e persistência de dados local (`StorageService.swift`).

---

### ⚙️ Como Executar o Projeto
1. **Clone o repositório:**
   ```bash
   git clone https://github.com/ana-ju-dev/TaskFlit.git

2. **Abra o projeto:**
  * Entre na pasta do projeto `TaskFlit`.
  * Dê dois cliques no arquivo `TaskFlit.xcodeproj` para abri-lo automaticamente no Xcode.

3. **Selecione o Simulador:**
   * Na barra superior do Xcode, escolha o dispositivo simulador de sua preferência (ex: *iPhone 17*).

4. **Execute o App:**
   4.1. **Se Usar o Simulador do Xcode**
      * Pressione o atalho `Cmd + R` no teclado ou clique no botão **Play (▶)** localizado no canto superior esquerdo do Xcode.
   4.2.   **Se Usar um Dispositivo IOS (iPhone)**
     * Conecte o dispositivo no mac via cabo
     * Nas opções de simulador, procure o nome do seu dispositivo e selecione.
     * Rode o app.
     * Abra os ajustes do dipositivo.
     * Na aba de pesquisa digite "VPN",
     * Aperte na segunda opção "Gestão de VPN e Dispositivo".
     * Na aba "App do Deenvolvedor", aperte no email do desenvolvedor.
     * Aperte em "Confiar em "email@desenvolvedor".

---

### 👤 Desenvolvido por

* **Ana Júlia da Cunha Pereira** — Estudante de Análise e Desenvolvimento de Sistemas (UNIFESO)
* https://github.com/ana-ju-dev
