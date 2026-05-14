const { spawnSync } = require("child_process");

const filesToPublish = [
  "data/ZafiroMenu.xlsx",
  "public/data/menu.json",
  "docs/data/menu.json",
  "docs/build-meta.json",
];

const commitMessage = process.env.MENU_PUBLISH_MESSAGE || "Update menu data";

function run(command, args, options = {}) {
  const executable = process.platform === "win32" && command === "npm" ? "npm.cmd" : command;
  const result = spawnSync(executable, args, {
    cwd: process.cwd(),
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

function hasStagedChanges() {
  const result = run("git", ["diff", "--cached", "--quiet"], {
    allowFailure: true,
    capture: true,
  });

  return result.status !== 0;
}

try {
  console.log("Building menu from local Excel...");
  run("npm", ["run", "menu:build:local"]);

  console.log("Staging menu files for GitHub Pages...");
  run("git", ["add", "--", ...filesToPublish]);

  if (!hasStagedChanges()) {
    console.log("No menu changes detected after staging. Nothing to commit or push.");
    process.exit(0);
  }

  console.log(`Creating commit: ${commitMessage}`);
  run("git", ["commit", "-m", commitMessage]);

  console.log("Pushing to origin main...");
  run("git", ["push", "origin", "main"]);

  console.log("Menu publish complete. GitHub Pages will publish from /docs on main.");
} catch (error) {
  console.error("Menu publish failed.");
  console.error(error.message);
  process.exit(1);
}
