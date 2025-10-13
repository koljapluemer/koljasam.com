import fs from "fs";
import path from "path";
import markdownIt from "markdown-it";

export default function(eleventyConfig) {
  const md = new markdownIt();
  eleventyConfig.addCollection("projects", c =>
    c.getFilteredByGlob("src/projects/*.md")
  );

  eleventyConfig.addCollection("mainProjects", c =>
    c.getFilteredByGlob("src/projects/*.md").filter(item => item.data.type === "main")
  );

  eleventyConfig.addCollection("activeProjects", c =>
    c.getFilteredByGlob("src/projects/*.md").filter(item => item.data.type === "active")
  );

  eleventyConfig.addCollection("pastProjects", c =>
    c.getFilteredByGlob("src/projects/*.md").filter(item => !item.data.type || (item.data.type !== "main" && item.data.type !== "active"))
  );

  eleventyConfig.addPassthroughCopy({ "static": "." });
  eleventyConfig.addPassthroughCopy({
    "node_modules/flowbite/dist/flowbite.min.js": "js/flowbite.min.js"
  });

  const projectImage = projectName => {
    const filePath = path.join("static", "img", "projects", `${projectName}.webp`);
    return fs.existsSync(filePath)
      ? `<img src="/img/projects/${projectName}.webp" alt="${projectName}" class="h-48 w-auto max-w-full object-contain">`
      : "";
  };

  eleventyConfig.addShortcode("projectImage", projectImage);

  // expose as a Nunjucks global so includes and partials can access it
  eleventyConfig.addNunjucksGlobal("projectImage", projectImage);

  // add markdown filter
  eleventyConfig.addFilter("md", function(content) {
    return md.renderInline(content);
  });

  return {
    dir: { input: "src", output: "_site" },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk"
  };
}
