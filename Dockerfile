FROM python:3.11-slim

WORKDIR /app

# Instala dependências do sistema
RUN apt-get update && apt-get install -y \
    gcc \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copia e instala dependências Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copia TUDO do projeto (incluindo templates/img/)
COPY . .

# Cria apenas os diretórios que não existem
RUN mkdir -p uploads output

# Expõe a porta da aplicação
EXPOSE 8000

# Comando para iniciar a aplicação em produção
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "2"]