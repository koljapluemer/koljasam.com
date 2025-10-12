import fs from "fs";
import path from "path";
import markdownIt from "markdown-it";

export default function(eleventyConfig) {
  const md = new markdownIt();
  eleventyConfig.addCollection("projects", c =>
    c.getFilteredByGlob("src/projects/*.md")
  );

  eleventyConfig.addPassthroughCopy({ "static": "." });

  const projectImage = projectName => {
    const filePath = path.join("static", "img", "projects", `${projectName}.webp`);
    return fs.existsSync(filePath)
      ? `<img src="/img/projects/${projectName}.webp" alt="${projectName}" style="max-height: 300px; width: auto; object-fit: contain;">`
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
