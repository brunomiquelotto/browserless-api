FROM ghcr.io/puppeteer/puppeteer:latest

# Adiciona seu código
WORKDIR /app
COPY . .

# Instala dependências se necessário (Fastify)
RUN npm install

EXPOSE 3000
CMD ["node", "index.js"]