#!/usr/bin/env Rscript
# Script per unire i dati di inflazione della World Bank al master dataset
# Author: Data Processing
# Date: 2026-04-28

# Carica i pacchetti necessari
library(readr)
library(dplyr)
library(tidyr)
library(WDI)  # Per scaricare dati dalla World Bank

# Imposta il working directory
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# 1. Carica il master dataset
cat("Loading master dataset...\n")
master_data <- read_csv("../DATA/PROCESSED/master_dataset_ukraine.csv")

# Estrai i paesi e gli anni unici dal master dataset
countries_iso3 <- unique(master_data$iso3)
years <- unique(master_data$Year)

cat("Countries:", length(countries_iso3), "\n")
cat("Years:", min(years), "-", max(years), "\n")

# 2. Scarica i dati di inflazione dalla World Bank
cat("\nDownloading inflation data from World Bank...\n")

# Indicatore: FP.CPI.TOTL.ZG (Inflation, consumer prices - annual %)
inflation_data <- WDI(
  indicator = "FP.CPI.TOTL.ZG",
  country = countries_iso3,
  start = min(years),
  end = max(years),
  extra = FALSE,
  cache = NULL
)

# Rinomina le colonne per chiarezza
inflation_data <- inflation_data %>%
  rename(
    iso3 = iso2c,
    Year = year,
    Inflation = FP.CPI.TOTL.ZG
  ) %>%
  select(iso3, Year, Inflation)

cat("Inflation data downloaded successfully!\n")
cat("Rows:", nrow(inflation_data), "\n")

# 3. Unisci i dati
cat("\nMerging inflation data with master dataset...\n")

merged_data <- master_data %>%
  left_join(inflation_data, by = c("iso3" = "iso3", "Year" = "Year"))

# Verifica il merge
cat("Merged data shape:", nrow(merged_data), "rows x", ncol(merged_data), "columns\n")
cat("Missing inflation values:", sum(is.na(merged_data$Inflation)), "\n")

# 4. Salva il nuovo dataset
output_path <- "../DATA/PROCESSED/master_dataset_ukraine_inflation.csv"
cat("\nSaving merged dataset to:", output_path, "\n")

write_csv(merged_data, output_path)

cat("✓ Process completed successfully!\n")

# 5. Statistiche finali
cat("\n=== Summary Statistics ===\n")
cat("Output file:", output_path, "\n")
cat("Rows:", nrow(merged_data), "\n")
cat("Columns:", ncol(merged_data), "\n")
cat("\nColumns in the merged dataset:\n")
print(names(merged_data))

cat("\nInflation data summary:\n")
print(summary(merged_data$Inflation))

cat("\nSample of merged data:\n")
print(head(merged_data, 10))
