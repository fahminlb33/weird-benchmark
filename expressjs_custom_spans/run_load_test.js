import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 10,
  iterations: 100,
};

export default function () {
  const url = 'http://localhost:5000/login-bcrypt';
  const payload = JSON.stringify({
    user: 'REDACTED',
    password: 'REDACTED',
  });
  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const res = http.post(url, payload, params);
  check(res, {
    'is status 200': (r) => r.status === 200,
    'is accessToken available': (r) => r.body && r.body.includes('accessToken'),
  });

  sleep(1);
}
