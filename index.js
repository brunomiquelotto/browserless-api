import Fastify from "fastify";
import { launch } from "puppeteer";

const fastify = Fastify({ logger: true });

fastify.get("/render", async (request, reply) => {
  const url = request.query.url;

  if (!url) {
    return reply.status(400).send({ error: "Missing URL parameter" });
  }

  try {
    const browser = await launch({
      headless: "new",
      args: ["--no-sandbox", "--disable-setuid-sandbox"],
    });

    const page = await browser.newPage();
    await page.goto(url, { waitUntil: "networkidle2", timeout: 0 });

    const html = await page.content();
    await browser.close();

    reply.type("text/html").send(html);
  } catch (err) {
    request.log.error(err);
    reply.status(500).send({ error: "Failed to render page" });
  }
});

fastify.listen({ port: 3000, host: "0.0.0.0" }, (err) => {
  if (err) {
    fastify.log.error(err);
    process.exit(1);
  }
});
