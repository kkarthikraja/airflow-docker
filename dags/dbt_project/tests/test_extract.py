# tests/test_extract.py
import pytest
from unittest.mock import Mock
from fetch_weather import fetch_weather

def test_fetch_weather_success(monkeypatch):
    mock_response = Mock()
    mock_response.json.return_value = {"temp": 15.0, "humidity": 70}
    mock_response.raise_for_status.return_value = None
    monkeypatch.setattr("requests.get", lambda *args, **kwargs: mock_response)

    data = fetch_weather("dummy_key", "London")
    assert "temp" in data
    assert data["humidity"] == 70

def test_fetch_weather_retry(monkeypatch):
    mock_response = Mock()
    mock_response.raise_for_status.side_effect = HTTPError("500 Error")
    monkeypatch.setattr("requests.get", lambda *args, **kwargs: mock_response)

    with pytest.raises(Exception) as e:
        fetch_weather("dummy_key", "London", max_retries=2)
    assert "Failed after 2 retries" in str(e.value)