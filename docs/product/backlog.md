## 🧠 Поведение интерфейса и визуальные отклики

### 🧭 Рекомендации (советы)

- Пользователь создаёт советы вручную
- Условия отображения: например `Anxiety > 7` → «Не принимай решений»
- При соблюдени условий "совет" отображается на главном экране


### 🔵 Влияние состояний на визуальный интерфейс

- [ ] Реализовать динамическое отображение текущего состояния пользователя через визуальные эффекты в UI:
  - Цветовой блюр фона
  - Подсветка аватара персонажа
  - «Огоньки»/сигналы вокруг аватара, меняющие оттенок в зависимости от состояния
- [ ] Примеры использования:
  - `Clear Lens` → светлый нейтральный фон, отсутствие анимаций, минимализм
  - `Anxiety` → повышенный визуальный «шум», напряжённые цвета

**Цель:** усилить связь между внутренним состоянием пользователя и внешним видом интерфейса — без слов, через атмосферу.


## Бэклог на далекое будущее

### 🧍‍♂️ Отображение двух версий: приложения и человека

> Идея: визуализировать **два параллельных трека развития** — цифрового аватара (как развивается Game Mode как приложение) и самого пользователя (его личностный прогресс).

- [ ] Реализация "двойного прогресса": пользователь коммитит свои версии
  - Линия роста пользователя (скиллы, состояния, характеристики)
  - Линия развития приложения (открытие новых функций, зон, тем, визуальных эффектов)
- [ ] Отображение как timeline, split-screen или зеркальный интерфейс
- [ ] Внутриигровая биография: "История развития пользователя" и "История развития Game Mode"

---

### 🧠 Темы (Themes / Focus Zones)

> Идея: пользователи выбирают тему/направление развития, которая определяет стиль интерфейса, рекомендации, фокус скиллов.

- [ ] Введение системы **"Тем"**:
  - Примеры: "Фокус", "Стабильность", "Творчество", "Сострадание"
- [ ] Каждая тема:
  - Подсвечивает определённые скиллы
  - Задает кастомную атмосферу интерфейса (цвет, звук, стиль)
  - Меняет контекстные советы и внутреннюю логику отображения состояний
- [ ] Возможность сохранять прогресс по темам и сравнивать
- [ ] Автоматическая рекомендация темы на основе поведения / состояний

---

### ✨ Потенциальные эффекты

- Более глубокая персонализация
- Эмоциональный отклик от пользователя
- Чувство соавторства в создании и развитии Game Mode
- Возможность "отделения себя от тревоги": тревожится аватар → наблюдаю → понимаю → меняю