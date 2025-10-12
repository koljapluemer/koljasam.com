---
layout: layouts/base.njk
title: Home
---

# Welcome

Some intro text, whatever content you want here.

## Currently Working On
{% set projectCollection = collections.mainProjects %}
{% include "partials/project-list.njk" %}

## My Tools
{% set projectCollection = collections.activeProjects %}
{% include "partials/project-list.njk" %}

## Past Experiments
{% set projectCollection = collections.pastProjects %}
{% include "partials/project-list.njk" %}