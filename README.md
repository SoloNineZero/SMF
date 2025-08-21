# SMF (SocialMediaFeed) iOS App

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![iOS](https://img.shields.io/badge/iOS-16%2B-blue)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)
![CoreData](https://img.shields.io/badge/Persistence-CoreData-red)

## Описание
Приложение представляет собой упрощённую версию ленты социальной сети. Пользователь может просматривать посты, добавлять их в избранное и работать с оффлайн-данными через CoreData.

### Основные возможности
- Загрузка постов через API (JSONPlaceholder)
- Отображение постов в таблице:
  - Заголовок поста
  - Текст поста
  - Аватар пользователя (с РФ работает только с VPN)
- Сохранение постов в CoreData для оффлайн-доступа
- Лайки/избранное с сохранением состояния
- Анимация загрузки постов (shimmer)

## Скриншоты

| Лента (загрузка) | Лента (с данными) | Избранное (с данными) |
|-------------------|------------------|-------------------|
| <img width="320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-08-21 at 15 41 03" src="https://github.com/user-attachments/assets/120ffec7-9403-4951-b9b7-a1236ae14af3" /> | <img width="320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-08-21 at 15 41 14" src="https://github.com/user-attachments/assets/b59cc7c4-5bfd-43e7-877a-03b507b70024" /> | <img width="320" height="2868" alt="Simulator Screenshot - iPhone 16 Pro Max - 2025-08-21 at 15 41 28" src="https://github.com/user-attachments/assets/ccf65a85-380f-4d7a-a898-9196a3a8f0ae" /> |

