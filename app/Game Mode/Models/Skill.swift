import Foundation // Подключаем стандартный набор функций Swift (например, работу с датами, текстом и идентификаторами)

// Определяем структуру Skill
// struct — это описание одного объекта с конкретными данными (например, один навык)
struct Skill: Identifiable, Codable {
    let id: UUID // Уникальный номер для каждого Skill. UUID — это специальный тип для создания уникальных номеров.
    let name: String // Название навыка (например, "Planning" или "Stick-to-it'ness")

    // Пример из реальной жизни:
    // Skill — это как карточка в игре. У каждой карточки есть своё имя и уникальный номер.
}

// Дополнительные пояснения:
// Identifiable — говорит SwiftUI, что у каждого Skill есть уникальный id (чтобы их можно было удобно показывать в списке).
// Codable — позволяет сохранить Skill в файл или отправить по сети, и потом восстановить обратно в объект.
//let - только чтение, var - тогда свойство можно изменять после создания объекта
