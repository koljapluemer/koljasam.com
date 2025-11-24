import fs from "fs";
import path from "path";
import markdownIt from "markdown-it";
import { DateTime } from "luxon";

export default function(eleventyConfig) {
  let options = {
    html: true,
    breaks: true,
    linkify: true
  };

  eleventyConfig.setLibrary("md", markdownIt(options));
  eleventyConfig.addCollection("projects", c =>
    c.getFilteredByGlob("src/projects/*.md")
  );

  eleventyConfig.addCollection("a4", c =>
    c.getFilteredByGlob("src/a4/*.md")
  );

  eleventyConfig.addPassthroughCopy({ "static": "." });
  eleventyConfig.addPassthroughCopy({ "src/a4/media": "a4/media" });
  eleventyConfig.addPassthroughCopy({
    "node_modules/flowbite/dist/flowbite.min.js": "js/flowbite.min.js"
  });
  eleventyConfig.addPassthroughCopy({
    "node_modules/lucide/dist/umd/lucide.min.js": "js/lucide.min.js"
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
    return markdownIt(options).renderInline(content);
  });

  // format date using Luxon
  eleventyConfig.addFilter("formatDate", function(date) {
    const dt = DateTime.fromJSDate(date);
    return dt.toFormat('MMM d, yyyy');
  });

  return {
    dir: { input: "src", output: "_site" },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk"
  };
}
