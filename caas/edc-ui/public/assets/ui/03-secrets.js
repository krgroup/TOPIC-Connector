async function saveSecret() {
      if (!state.secretsAvailable) {
        await discoverSecretsApi(false);
        if (!state.secretsAvailable) { writeOut({ status: 404, error: 'Secrets API no disponible en este runtime.' }); return; }
      }
      const name = document.getElementById('secretName').value.trim();
      const value = document.getElementById('secretValue').value.trim();
      if (!name || !value) { writeOut({ status: 400, error: 'Nombre y valor requeridos.' }); return; }
      const payloads = [
        { '@context': { edc: 'https://w3id.org/edc/v0.0.1/ns/' }, '@type': 'Secret', '@id': name, value },
        { key: name, value },
      ];
      const endpoints = ['/v3/secrets', '/v3/secret'];
      let last = null;
      for (const endpoint of endpoints) {
        for (const payload of payloads) {
          const r = await callApi('POST', endpoint, JSON.stringify(payload), { silent: true });
          last = r;
          if (r.status >= 200 && r.status < 300) {
            writeOut({ status: r.status, data: r.data, endpoint, payloadType: payload['@type'] ? 'edc-secret' : 'key-value' });
            await listSecrets(false);
            return;
          }
        }
      }
      writeOut({ status: last?.status || 500, error: 'No se pudo guardar el secreto en ningun endpoint compatible.', lastResponse: last });
      await listSecrets(false);
    }

    function refreshSecretSelect() {
      const sel = document.getElementById('pubAuthSecret');
      if (!sel) return;
      const current = sel.value;
      sel.innerHTML = '<option value="">(opcional)</option>';
      state.secretNames.forEach(n => {
        const o = document.createElement('option');
        o.value = n;
        o.textContent = n;
        sel.appendChild(o);
      });
      if (state.secretNames.includes(current)) sel.value = current;
    }

    async function listSecrets(showOutput = true) {
      const r = await discoverSecretsApi(showOutput);
      return r;
    }
    async function deleteSecret() {
      if (!state.secretsAvailable) {
        await discoverSecretsApi(false);
        if (!state.secretsAvailable) { writeOut({ status: 404, error: 'Secrets API no disponible en este runtime.' }); return; }
      }
      const name = document.getElementById('secretName').value.trim();
      if (!name) { writeOut({ status: 400, error: 'Nombre requerido.' }); return; }
      const candidates = [`/v3/secrets/${encodeURIComponent(name)}`, `/v3/secret/${encodeURIComponent(name)}`];
      let last = null;
      for (const path of candidates) {
        const r = await callApi('DELETE', path, undefined, { silent: true });
        last = r;
        if (r.status >= 200 && r.status < 300) {
          writeOut({ status: r.status, data: r.data, endpoint: path });
          await listSecrets(false);
          return;
        }
      }
      writeOut({ status: last?.status || 500, error: 'No se pudo borrar el secreto con los endpoints probados.', lastResponse: last });
      await listSecrets(false);
    }

