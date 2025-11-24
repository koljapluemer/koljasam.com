import fs from "fs";
import path from "path";
import markdownIt from "markdown-it";
import { DateTime } from "luxon";

export default function(eleventyConfig) {
  const md = new markdownIt();
  eleventyConfig.addCollection("projects", c =>
    c.getFilteredByGlob("src/projects/*.md")
  );

  eleventyConfig.addCollection("a4", c =>
    c.getFilteredByGlob("src/a4/*.md")
  );

  eleventyConfig.addPassthroughCopy({ "static": "." });
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
    return md.renderInline(content);
  });

  // parse date from filename format "DD-MM-YY Title"
  eleventyConfig.addFilter("parseFilenameDate", function(fileSlug) {
    const datePart = fileSlug.split(' ')[0];
    const [day, month, year] = datePart.split('-');
    const dt = DateTime.fromObject({ year: 2000 + parseInt(year), month: parseInt(month), day: parseInt(day) });
    return dt.toFormat('MMM d, yyyy');
  });

  // extract title from filename format "DD-MM-YY Title"
  eleventyConfig.addFilter("extractTitle", function(fileSlug) {
    return fileSlug.split(' ').slice(1).join(' ');
  });

  return {
    dir: { input: "src", output: "_site" },
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk"
  };
}
