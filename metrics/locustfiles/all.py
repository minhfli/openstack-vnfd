from locust import FastHttpUser, HttpUser, task
import locust.stats
from locust import constant_throughput, constant_pacing, constant, between
import time

# run with locust

# for stats csv
locust.stats.PERCENTILES_TO_REPORT = [
    0.25,
    0.50,
    0.65,
    0.75,
    0.80,
    0.90,
    0.95,
    0.99,
    1.00,
]
# for UI
locust.stats.PERCENTILES_TO_CHART = [0.25, 0.50, 0.75, 0.95, 0.99]
locust.stats.PERCENTILES_TO_STATISTICS = [0.25, 0.50, 0.75, 0.95, 0.99]
locust.stats.CONSOLE_STATS_INTERVAL_SEC = 30
locust.stats.HISTORY_STATS_INTERVAL_SEC = 30
locust.stats.CSV_STATS_INTERVAL_SEC = 30
locust.stats.CURRENT_RESPONSE_TIME_PERCENTILE_WINDOW = 30


timeout = 50  # seconds, for all users

wait_time1 = constant(1)
wait_time2 = constant(1)
wait_time3 = constant(1)
wait_time4 = constant(1)
url1 = "/burn.php?n=20000"
url2 = "/burn.php?n=30000"
url3 = "/burn.php?n=50000"
url4 = "/burn.php?n=70000"

# 120 user for vertical scaling test


class MyUser1(HttpUser):
    wait_time = wait_time1
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url1)


class MyUser2(HttpUser):
    wait_time = wait_time2
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url2)


class MyUser3(HttpUser):
    wait_time = wait_time3
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url3)


class MyUser4(HttpUser):
    wait_time = wait_time4
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url4)
