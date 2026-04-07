const { XLSX, workbookToMenuJson, saveMenuJson } = require("./menu-utils.cjs");

const SHAREPOINT_URL =
  "https://udlaedu-my.sharepoint.com/:x:/g/personal/yo_uni_udla_edu_co/IQAIE5vsMF3ZTY3KXg5kxwMWAV6jsfJkqxk20XtwQ8s9GsY";

function buildDownloadUrl(url) {
  const parsed = new URL(url);
  parsed.searchParams.set("download", "1");
  return parsed.toString();
}

function looksLikeXlsx(buffer) {
  if (!buffer || buffer.length < 4) return false;
  return (
    buffer[0] === 0x50 &&
    buffer[1] === 0x4b &&
    buffer[2] === 0x03 &&
    buffer[3] === 0x04
  );
}

async function main() {
  try {
    const downloadUrl = buildDownloadUrl(SHAREPOINT_URL);
    console.log(`🌐 Intentando descargar Excel desde SharePoint...`);
    console.log(downloadUrl);

    const response = await fetch(downloadUrl, {
      method: "GET",
      redirect: "follow",
    });

    if (!response.ok) {
      throw new Error(`HTTP ${response.status} ${response.statusText}`);
    }

    const arrayBuffer = await response.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);

    if (!looksLikeXlsx(buffer)) {
      const contentType = response.headers.get("content-type") || "desconocido";
      throw new Error(
        `La respuesta no parece ser un archivo .xlsx válido. Content-Type: ${contentType}`
      );
    }

    const workbook = XLSX.read(buffer, { type: "buffer" });
    const data = workbookToMenuJson(workbook);
    saveMenuJson(data);

    console.log("✅ Excel descargado y convertido correctamente desde el link.");
  } catch (error) {
    console.error("❌ No se pudo generar menu.json desde el link compartido.");
    console.error(`Motivo: ${error.message}`);
    console.error("👉 Usa el Excel local en data/ZafiroMenu.xlsx y ejecuta: npm run menu:build:local");
    process.exit(1);
  }
}

main();