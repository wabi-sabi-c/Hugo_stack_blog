<#
.SYNOPSIS
    Create a new Hugo series chapter (Leaf Bundle)
.DESCRIPTION
    Usage: .\New-Chapter.ps1 "1. Chapter Title"
.EXAMPLE
    .\New-Chapter.ps1 "1. Introduction to FastAPI"
#>

param([string]$Title)

$SeriesRoot = "post/full-stack-fastapi-template"
$ArchetypeKind = "series"

# Ensure archetype exists
$ArchetypeDir = "archetypes\$ArchetypeKind"
$ArchetypeFile = "$ArchetypeDir\index.md"
if (-not (Test-Path $ArchetypeFile)) {
    New-Item -Path $ArchetypeDir -ItemType Directory -Force | Out-Null
    $template = @"
---
title: "{{ replace .Name "-" " " | title }}"
date: {{ .Date }}
draft: true
series: "Full Stack FastAPI Template"
weight: 1
chapter: "1"
description: ""
image: "cover.jpg"
categories: ["project"]
tags: ["FastAPI", "全栈开发", "Python"]
---

<!--more-->
"@
    $template | Set-Content -Path $ArchetypeFile -Encoding UTF8
}

# Parse title
if ($Title -match '^(\d+)\.\s+(.+)$') {
    $num = $matches[1]
    $name = $matches[2]
} else {
    Write-Host "ERROR: Title format must be 'number. Title' (e.g., '1. My Chapter')"
    exit 1
}

# Clean folder name
$clean = $name -replace '[^\w\-]', '-' -replace '-+', '-' -replace '^-|-$', ''
$folder = "{0:D2}-{1}" -f [int]$num, $clean
$full = "content\$SeriesRoot\$folder"

# Check existence
if (Test-Path $full) {
    $choice = Read-Host "Chapter exists. Overwrite? (y/N)"
    if ($choice -ne 'y' -and $choice -ne 'Y') { exit 0 }
    Remove-Item -Path $full -Recurse -Force
}

# Create with Hugo
Write-Host "Creating chapter: $Title"
hugo new --kind $ArchetypeKind "$SeriesRoot/$folder"

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Hugo command failed. Check Hugo installation."
    exit 1
}

# Fix weight and chapter (line-by-line replacement, more robust)
$idx = "$full\index.md"
if (Test-Path $idx) {
    $lines = Get-Content -Path $idx -Encoding UTF8
    $modified = $false
    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -match '^weight:\s*\d+') {
            $lines[$i] = "weight: $num"
            $modified = $true
            Write-Host "Updated weight to $num"
        }
        if ($lines[$i] -match '^chapter:\s*".*"') {
            $lines[$i] = "chapter: `"$num`""
            $modified = $true
            Write-Host "Updated chapter to `"$num`""
        }
    }
    if ($modified) {
        $lines | Set-Content -Path $idx -Encoding UTF8
        Write-Host "Successfully updated weight and chapter."
    } else {
        Write-Host "WARNING: weight/chapter fields not found. Please set manually."
    }
} else {
    Write-Host "ERROR: index.md not found at $idx"
    exit 1
}

Write-Host "Done! Location: $full"
