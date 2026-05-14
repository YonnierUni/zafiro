const fs = require("fs");
const path = require("path");
const { spawnSync } = require("child_process");

const rootDir = path.resolve(__dirname, "..");
const distDir = path.join(rootDir, "dist");
const docsDir = path.join(rootDir, "docs");

const commitMessage = process.env.SITE_PUBLISH_MESSAGE || "Update published site";

function run(command, args, options = {}) {
  const executable = process.platform === "win32" && command === "npm" ? "npm.cmd" : command;
  const result = spawnSync(executable, args, {
    cwd: rootDir,
    encoding: "utf8",
    shell: false,
    stdio: options.capture ? "pipe" : "inherit",
  });

  if (result.error) {
    throw result.error;
  }

  if (result.status !== 0 && !options.allowFailure) {
    const details = result.stderr || result.stdout || "";
    throw new Error(`${executable} ${args.join(" ")} failed.\n${details}`.trim());
  }

  return result;
}

function copyDistToDocs() {
  if (!fs.existsSync(distDir)) {
    throw new Error("dist folder was not created. Build did not produce publishable files.");
  }

  fs.cpSync(distDir, docsDir, {
    recursive: true,
    force: true,
  });
}

function hasStagedChanges() {
  const result = run("git", ["diff", "--cached", "--quiet"], {
    allowFailure: true,
    capture: true,
  });

  return result.status !== 0;
}

try {
  console.log("Refreshing menu data and public assets...");
  run("npm", ["run", "menu:build:local"]);

  console.log("Building production site...");
  run("npm", ["run", "build"]);

  console.log("Copying dist to docs for GitHub Pages...");
  copyDistToDocs();

  console.log("Staging published site files...");
  run("git", ["add", "--", "data/ZafiroMenu.xlsx", "public", "docs", "scripts", "package.json"]);

  if (!hasStagedChanges()) {
    console.log("No site changes detected after build. Nothing to commit or push.");
    process.exit(0);
  }

  console.log(`Creating commit: ${commitMessage}`);
  run("git", ["commit", "-m", commitMessage]);

  console.log("Pushing to origin main...");
  run("git", ["push", "origin", "main"]);

  console.log("Site publish complete. GitHub Pages will publish from /docs on main.");
} catch (error) {
  console.error("Site publish failed.");
  console.error(error.message);
  process.exit(1);
}
