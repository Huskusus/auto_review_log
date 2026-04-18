#!/bin/bash

set -e

LOG_PATH_DIR="${1}"
OUTPUT_FILE="$HOME/log_report.txt"
ERROR_PAT="error|Error|ERROR|failed|Failed|FAILED|critical|Critical"

if [ ! -d "$LOG_PATH_DIR" ]; then
	echo "Директории '$LOG_PATH_DIR' НЕ существует"
	exit 1
fi

{
	echo "Отчет по анализу логов:"
	echo "Дата: $(date '+%Y-%m-%d %H:%M:%S')"
	echo "Исходная директория: $LOG_PATH_DIR"
	
	echo "Лог-файлы:"
	find "$LOG_PATH_DIR" -type f -name "*.log" 2>/dev/null | head -20
	
	echo "Общее количество строк с ошибками:"
	COUNT_ER=$(grep -r -i -E "$ERROR_PAT" "$LOG_PATH_DIR" 2>/dev/null | wc -l)
	echo "Найдено ко0во ошибок: $COUNT_ER"
	
	echo "Последние 10 ошибок:"
	grep -r -i -E "$ERROR_PAT" "$LOG_PATH_DIR" 2>/dev/null | tail -10

	echo "Файл с полным отчетом в директории: $OUTPUT_FILE"

} | tee "$OUTPUT_FILE"



