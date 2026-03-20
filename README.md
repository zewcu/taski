# Taski

Taski — веб-приложение для управления задачами. Позволяет создавать, редактировать и отслеживать выполнение задач.

Стек: **React** (фронтенд) + **Django REST Framework** (бэкенд) + **PostgreSQL** (база данных) + **Docker** (контейнеризация).

---

## Технологии

- Python 3.13
- Django 4.2
- Django REST Framework 3.14
- React (Node.js 22)
- PostgreSQL
- Docker / Docker Compose
- GitHub Actions (CI/CD)
- Gunicorn
- Nginx

---

## Локальный запуск (без Docker)

### Требования

- Python 3.10+
- Node.js и npm
- PostgreSQL

### Бэкенд

```bash
cd backend
python -m venv venv
source venv/bin/activate      # Windows: venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

API будет доступно по адресу: `http://localhost:8000/api/`

### Фронтенд

```bash
cd frontend
npm install
npm start
```

Фронтенд будет доступен по адресу: `http://localhost:3000`

---

## Запуск в Docker

### Требования

- Docker
- Docker Compose

### Переменные окружения

Создайте файл `.env` в корне проекта на основе `.env.example`:

```env
SECRET_KEY=ваш_секретный_ключ
DEBUG=False
ALLOWED_HOSTS=ваш_домен.com,localhost
POSTGRES_DB=taski
POSTGRES_USER=taski_user
POSTGRES_PASSWORD=ваш_пароль
DB_HOST=db
DB_PORT=5432
```

### Запуск

```bash
docker compose up -d --build
```

После запуска выполните миграции:

```bash
docker compose exec backend python manage.py migrate
docker compose exec backend python manage.py collectstatic --noinput
```

Приложение будет доступно по адресу: `http://localhost`

---

## CI/CD

Проект использует **GitHub Actions** для автоматической сборки и деплоя.

При пуше в ветку `main`:

1. Собирается Docker-образ (фронтенд + бэкенд)
2. Образ публикуется на Docker Hub
3. Деплой на сервер через Render

### Необходимые секреты в GitHub

| Секрет | Описание |
|--------|----------|
| `DOCKER_USERNAME` | Логин на Docker Hub |
| `DOCKER_PASSWORD` | Пароль на Docker Hub |

---

## Структура проекта

```
taski/
├── .github/
│   └── workflows/
│       └── main.yml        # CI/CD pipeline
├── backend/                # Django REST API
│   ├── api/                # Приложение с эндпоинтами задач
│   ├── backend/            # Настройки Django
│   ├── manage.py
│   └── requirements.txt
├── frontend/               # React SPA
│   ├── public/
│   └── src/
├── Dockerfile              # Мультистейдж-сборка фронт + бэк
├── .env.example
└── README.md
```

---

## API

| Метод | Endpoint | Описание |
|-------|----------|----------|
| GET | `/api/tasks/` | Список задач |
| POST | `/api/tasks/` | Создать задачу |
| GET | `/api/tasks/{id}/` | Получить задачу |
| PATCH | `/api/tasks/{id}/` | Обновить задачу |
| DELETE | `/api/tasks/{id}/` | Удалить задачу |

---

## Лицензия

MIT License
