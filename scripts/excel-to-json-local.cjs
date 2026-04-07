const path = require("path");
const { XLSX, workbookToMenuJson, saveMenuJson } = require("./menu-utils.cjs");

try {
  const inputPath = path.resolve(__dirname, "../data/ZafiroMenu.xlsx");

  console.log(`📄 Leyendo Excel local: ${inputPath}`);
  const workbook = XLSX.readFile(inputPath);

  const data = workbookToMenuJson(workbook);
  saveMenuJson(data);
} catch (error) {
  console.error("❌ Error generando menu.json desde archivo local.");
  console.error(error.message);
  process.exit(1);
}