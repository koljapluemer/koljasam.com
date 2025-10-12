---
layout: layouts/base.njk
title: Home
---

# Kolja Sam Pluemer

My mission is to make the world a better place by building excellent tools for learning.

## Primary Projects
{% set projectCollection = collections.mainProjects %}
{% set gridClass = "is-col-min-24" %}
{% include "partials/project-list.njk" %}

## Currently Working On
{% set projectCollection = collections.activeProjects %}
{% include "partials/project-list.njk" %}

## Past Experiments
{% set projectCollection = collections.pastProjects %}
{% include "partials/project-list.njk" %}