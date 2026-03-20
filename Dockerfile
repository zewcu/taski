# Сборка фронтенда
FROM node:22-alpine as frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm install
COPY frontend/ ./
RUN npm run build

# Бэкенд
FROM python:3.13-slim
WORKDIR /app
COPY backend/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
COPY backend/ ./backend

# Копируем собранный фронтенд
COPY --from=frontend-build /app/frontend/build ./backend/frontend/build

# Собираем статику Django
RUN python backend/manage.py collectstatic --noinput

EXPOSE 8000
CMD ["gunicorn", "backend.wsgi:application", "--bind", "0.0.0.0:$PORT"]
