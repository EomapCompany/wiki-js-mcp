# Wiki.js MCP Server
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ ./src/
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

RUN useradd --create-home --uid 1000 appuser \
    && mkdir -p /data \
    && chown -R appuser:appuser /app /data
USER appuser

# Persisted state (SQLite mapping DB + log file) lives under /data.
# Mount a volume there to survive container recreation.
ENV WIKIJS_MCP_DB=/data/wikijs_mappings.db \
    LOG_FILE=/data/wikijs_mcp.log \
    MCP_HTTP_HOST=0.0.0.0 \
    MCP_HTTP_PORT=8000

EXPOSE 8000

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["python", "src/wiki_mcp_server.py"]
