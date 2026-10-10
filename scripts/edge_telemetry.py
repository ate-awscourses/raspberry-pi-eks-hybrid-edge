#!/usr/bin/env python3

import json
import os
import platform
import shutil
import socket
from datetime import datetime, timezone
from pathlib import Path

PROJECT_DIR = Path(__file__).resolve().parent.parent
OUTPUT_FILE = PROJECT_DIR / "data" / "telemetry.json"


def read_cpu_temperature():
    """Read Raspberry Pi CPU temperature when the OS exposes it."""
    temperature_file = Path(
        "/sys/class/thermal/thermal_zone0/temp"
    )

    try:
        raw_value = int(temperature_file.read_text().strip())
        return round(raw_value / 1000, 1)
    except (OSError, ValueError):
        return None


def collect_metrics():
    """Collect basic system-health metrics."""
    disk = shutil.disk_usage("/")

    return {
        "timestamp_utc": datetime.now(timezone.utc).isoformat(),
        "device": {
            "hostname": socket.gethostname(),
            "os": platform.system(),
            "architecture": platform.machine(),
            "python_version": platform.python_version(),
        },
        "cpu": {
            "load_average_1m_5m_15m": list(os.getloadavg()),
            "temperature_celsius": read_cpu_temperature(),
        },
        "disk": {
            "total_bytes": disk.total,
            "used_bytes": disk.used,
            "free_bytes": disk.free,
            "used_percent": round(
                disk.used / disk.total * 100, 2
            ),
        },
    }


def main():
    metrics = collect_metrics()
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT_FILE.write_text(
        json.dumps(metrics, indent=2) + "\n",
        encoding="utf-8",
    )

    print(json.dumps(metrics, indent=2))
    print(f"\nSaved telemetry to: {OUTPUT_FILE}")


if __name__ == "__main__":
    main()

