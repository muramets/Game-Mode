# 🏗️ Архитектура проекта Game Mode

## 📱 Технический стек

Для разработки приложения Game Mode будет использоваться следующий технический стек:

- **Платформа:** iOS/iPadOS
- **Язык программирования:** Swift
- **Фреймворк UI:** SwiftUI
- **Архитектурный паттерн:** MVVM (Model-View-ViewModel)
- **Хранение данных:** CloudKit + Core Data
- **Система сборки:** Swift Package Manager (SPM)
- **Интеграция:** iCloud для синхронизации

### Обоснование выбора

1. **SwiftUI** - современный декларативный подход к созданию пользовательских интерфейсов, который намного проще для освоения, чем UIKit. Он позволяет быстро создавать адаптивные интерфейсы с минимальным количеством кода.

2. **MVVM** (Model-View-ViewModel) - архитектурный паттерн, который хорошо сочетается со SwiftUI и позволяет разделить логику приложения от его представления. Это упрощает рефакторинг, тестирование и развитие приложения в будущем.

3. **CloudKit + Core Data** - использование Core Data для локального хранения и CloudKit для синхронизации между устройствами через iCloud. Это встроенное решение Apple, которое не требует создания собственного бэкенда.

## 🛠️ Системные требования

- **Xcode 14+** (лучше Xcode 15+) для разработки
- **macOS Ventura+** для запуска Xcode
- **iOS 16+** / **iPadOS 16+** как целевые платформы
- **Apple Developer Account** для тестирования на физических устройствах и использования CloudKit

## 📐 Архитектура MVVM

MVVM — это паттерн проектирования, состоящий из трех компонентов:

### 1. Model (Модель)
- Представляет структуру данных
- Содержит бизнес-логику
- Не зависит от UI

### 2. View (Представление)
- Отображает данные пользователю
- Реагирует на действия пользователя
- Не содержит логики, только представление

### 3. ViewModel (Модель представления)
- Служит связующим звеном между Model и View
- Обрабатывает действия пользователя
- Форматирует данные для отображения
- Уведомляет View об изменениях

### Преимущества для Game Mode:

- **Разделение ответственности** — каждый компонент отвечает за свою функцию
- **Тестируемость** — легко писать тесты для каждого компонента по отдельности
- **Масштабируемость** — можно легко добавлять новые функции без изменения существующих
- **Простота поддержки** — код хорошо структурирован и понятен

## 📂 Структура проекта

```
GameMode/
├── App/
│   ├── GameModeApp.swift    # Точка входа в приложение
│   └── AppDelegate.swift    # Делегат приложения
├── Models/                  # Модели данных
│   ├── Skill.swift          # Модель навыка
│   ├── Trait.swift          # Модель характеристики
│   ├── State.swift          # Модель состояния
│   └── Relationship.swift   # Модель связей между объектами
├── ViewModels/              # Модели представлений
│   ├── SkillsViewModel.swift
│   ├── TraitsViewModel.swift
│   ├── StatesViewModel.swift
│   └── CharacterViewModel.swift
├── Views/                   # Представления (UI)
│   ├── Main/                # Основные экраны
│   │   ├── MainView.swift   # Главный экран с паутинкой
│   │   ├── CharacterView.swift
│   │   └── NavigationView.swift
│   ├── Skills/              # Экраны, связанные с навыками
│   │   ├── SkillListView.swift
│   │   ├── SkillDetailView.swift
│   │   └── SkillCheckInView.swift
│   ├── Traits/              # Экраны, связанные с характеристиками
│   │   ├── TraitListView.swift
│   │   ├── TraitDetailView.swift
│   │   └── TraitGraphView.swift
│   ├── States/              # Экраны, связанные с состояниями
│   │   ├── StateListView.swift
│   │   ├── StateDetailView.swift
│   │   └── StateVisualizationView.swift
│   └── Components/          # Повторно используемые компоненты
│       ├── SpiderWebView.swift
│       ├── CheckInButton.swift
│       ├── GraphView.swift
│       └── ...
├── Services/                # Сервисы
│   ├── DataManager.swift    # Управление данными
│   ├── CloudSyncService.swift # Синхронизация с iCloud
│   └── NotificationService.swift # Уведомления
├── Utils/                   # Утилиты
│   ├── Extensions/          # Расширения Swift
│   ├── Helpers/             # Вспомогательные функции
│   └── Constants.swift      # Константы приложения
└── Resources/               # Ресурсы
    ├── Assets.xcassets      # Изображения и цвета
    ├── Localizable.strings  # Локализация
    └── Info.plist           # Информация о приложении
```

## 📊 Модели данных

### Skill (Навык)

```swift
struct Skill: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var checkIns: [CheckIn]
    var lightValue: Double = 0.1
    var mediumValue: Double = 0.2
    var strongValue: Double = 0.3
    var relationships: [Relationship]
}

struct CheckIn: Identifiable, Codable {
    let id: UUID
    let date: Date
    let value: Double
    var comment: String?
    var mediaURL: URL?
}
```

### Trait (Характеристика)

```swift
struct Trait: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var isConstructive: Bool
    var currentValue: Double
    var targetValue: Double
    var history: [HistoryPoint]
    var relationships: [Relationship]
}

struct HistoryPoint: Identifiable, Codable {
    let id: UUID
    let date: Date
    let value: Double
    let contributingEvents: [ContributingEvent]
}

struct ContributingEvent: Identifiable, Codable {
    let id: UUID
    let sourceType: SourceType // skill или trait
    let sourceName: String
    let value: Double
}

enum SourceType: String, Codable {
    case skill, trait
}
```

### State (Состояние)

```swift
struct State: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var currentValue: Double
    var influences: [Influence]
}

struct Influence: Identifiable, Codable {
    let id: UUID
    let sourceType: SourceType // skill или trait
    let sourceName: String
    let coefficient: Double // положительное или отрицательное значение
}
```

### Relationship (Связь)

```swift
struct Relationship: Identifiable, Codable {
    let id: UUID
    let sourceId: UUID
    let sourceType: EntityType
    let targetId: UUID
    let targetType: EntityType
    let coefficient: Double
}

enum EntityType: String, Codable {
    case skill, trait, state
}
```

## 🔄 ViewModels

### SkillsViewModel

```swift
class SkillsViewModel: ObservableObject {
    @Published var skills: [Skill] = []
    
    func addSkill(name: String, description: String) { ... }
    func checkIn(skillId: UUID, value: Double, comment: String?, media: URL?) { ... }
    func updateRelationships(skillId: UUID, relationships: [Relationship]) { ... }
}
```

### TraitsViewModel

```swift
class TraitsViewModel: ObservableObject {
    @Published var traits: [Trait] = []
    
    func addTrait(name: String, description: String, isConstructive: Bool, target: Double) { ... }
    func updateTraitValue(traitId: UUID, value: Double, comment: String?) { ... }
    func updateRelationships(traitId: UUID, relationships: [Relationship]) { ... }
}
```

### StatesViewModel

```swift
class StatesViewModel: ObservableObject {
    @Published var states: [State] = []
    
    func addState(name: String, description: String) { ... }
    func updateInfluences(stateId: UUID, influences: [Influence]) { ... }
    func calculateCurrentState() { ... }
}
```

### CharacterViewModel

```swift
class CharacterViewModel: ObservableObject {
    @Published var character: Character
    
    // Объединяет информацию из всех моделей для отображения на главном экране
    func getSpiderWebData() -> [SpiderWebSegment] { ... }
    func getCurrentStates() -> [State] { ... }
    func getRecommendations() -> [Recommendation] { ... }
}
```

## 💾 Хранение данных и синхронизация

### Core Data + CloudKit

1. **Core Data** — для локального хранения данных:
   - Создание схемы данных на основе моделей
   - CRUD операции
   - Отслеживание изменений

2. **CloudKit** — для синхронизации между устройствами:
   - Автоматическая синхронизация через iCloud
   - Разрешение конфликтов
   - Хранение мультимедиа (скриншоты)

### Пример реализации DataManager:

```swift
class DataManager {
    static let shared = DataManager()
    
    let persistentContainer: NSPersistentCloudKitContainer
    
    init() {
        persistentContainer = NSPersistentCloudKitContainer(name: "GameMode")
        persistentContainer.loadPersistentStores { ... }
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() { ... }
    
    // CRUD операции для моделей
    func saveSkill(_ skill: Skill) { ... }
    func fetchSkills() -> [Skill] { ... }
    // и т.д.
}
```

## 👁️ Представления (UI)

### MainView

Главный экран с паутинкой (Spider Web) для визуализации скиллов, характеристик и состояний:

```swift
struct MainView: View {
    @ObservedObject var viewModel: CharacterViewModel
    
    var body: some View {
        ZStack {
            // Фоновые эффекты, зависящие от состояния
            BackgroundEffectView(states: viewModel.getCurrentStates())
            
            VStack {
                // Заголовок и панель навигации
                // ...
                
                // Паутинка скиллов/характеристик
                SpiderWebView(segments: viewModel.getSpiderWebData())
                
                // Рекомендации
                RecommendationView(recommendations: viewModel.getRecommendations())
                
                // Кнопки быстрого доступа
                QuickAccessButtons()
            }
        }
    }
}
```

### Компоненты

#### SpiderWebView

Визуализация скиллов или характеристик в виде паутинки:

```swift
struct SpiderWebView: View {
    var segments: [SpiderWebSegment]
    
    var body: some View {
        // Реализация паутинки с использованием Path или Canvas
    }
}

struct SpiderWebSegment {
    let name: String
    let value: Double
    let maxValue: Double
    let color: Color
}
```

#### GraphView

Для отображения графиков чек-инов и прогресса:

```swift
struct GraphView<T: GraphDataPoint>: View {
    var dataPoints: [T]
    var xLabel: String
    var yLabel: String
    
    var body: some View {
        // Реализация графика
    }
}

protocol GraphDataPoint {
    var x: Double { get }
    var y: Double { get }
    var description: String { get }
}
```

## 🚀 Шаги по реализации с помощью AI

### 1. Настройка окружения (с AI-помощником)

- Установка Xcode
- Создание нового проекта SwiftUI
- Настройка GitHub репозитория

### 2. Создание базовой структуры проекта (с AI-помощником)

- Создание директорий согласно структуре проекта
- Настройка базового навигационного потока

### 3. Реализация моделей данных (с AI-помощником)

- Создание Swift-структур для моделей данных
- Настройка Core Data схемы
- Интеграция CloudKit

### 4. Реализация ViewModels (с AI-помощником)

- Создание ViewModel-классов
- Реализация бизнес-логики
- Связывание с моделями данных

### 5. Реализация основных представлений (с AI-помощником)

- Создание главного экрана
- Реализация паутинки (Spider Web)
- Разработка экранов для скиллов, характеристик и состояний

### 6. Реализация функции чек-инов (с AI-помощником)

- Интерфейс для чек-инов скиллов
- Обновление характеристик и состояний
- Сохранение и синхронизация данных

### 7. Реализация рекомендаций и "Хороших идей" (с AI-помощником)

- Интерфейс для рекомендаций
- Функционал сохранения снэпшотов состояний

### 8. Тестирование и отладка (с AI-помощником)

- Тестирование на симуляторе
- Отладка проблем синхронизации
- Исправление ошибок

### 9. Подготовка к выпуску (с AI-помощником)

- Оптимизация производительности
- Финальные улучшения UI
- Подготовка для App Store

## 🔍 Рекомендации для начинающих разработчиков

1. **Начинайте с малого** — сначала реализуйте основные функции (чек-ины скиллов), затем добавляйте более сложные (графики, рекомендации).

2. **Используйте AI-помощников** — они могут:
   - Генерировать шаблонный код
   - Объяснять программные концепции
   - Помогать с отладкой
   - Предлагать лучшие практики

3. **Изучайте готовые решения** — многие UI-компоненты и анимации можно найти в сообществе SwiftUI.

4. **Итеративный подход** — создавайте работающее приложение постепенно, улучшая его шаг за шагом.

5. **Используйте Xcode Previews** — для быстрой разработки UI без постоянного запуска приложения.

6. **Не бойтесь экспериментировать** — SwiftUI позволяет легко пробовать разные подходы к дизайну.

## 🧩 Дополнительные библиотеки, которые могут быть полезны

- **Swift Charts** (встроено с iOS 16+) — для создания красивых графиков
- **Combine** — для работы с асинхронными событиями
- **SwiftDate** — для удобной работы с датами
- **KeychainAccess** — для безопасного хранения чувствительных данных

Эта архитектура обеспечивает современный, масштабируемый подход к разработке приложения Game Mode, оставаясь при этом доступной для освоения начинающим разработчиком с помощью AI-ассистентов.