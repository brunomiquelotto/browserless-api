FROM node:20

# Instala dependências do Chromium
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libasound2 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libgtk-3-0 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    wget \
    ca-certificates \
    --no-install-recommends \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Diretório de trabalho
WORKDIR /app

# Instala dependências do projeto
COPY package.json ./
RUN npm install

# Copia os arquivos da aplicação
COPY . .

# Expõe a porta da API
EXPOSE 3000

CMD ["npm", "start"]