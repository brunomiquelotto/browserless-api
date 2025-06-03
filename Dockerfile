FROM node:20

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

WORKDIR /app

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]