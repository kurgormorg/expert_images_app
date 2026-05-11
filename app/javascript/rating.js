document.addEventListener("submit", function (event) {
  const form = event.target;

  if (form.id !== "rating-form") return;

  event.preventDefault();

  const valueInput = form.querySelector("#rating-input");
  const imageIdInput = form.querySelector("[name='image_id']");
  const result = document.getElementById("rating-result");
  const token = document.querySelector("meta[name='csrf-token']")?.content;

  fetch(form.action, {
    method: "POST",
    headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "X-CSRF-Token": token
    },
    body: JSON.stringify({
      image_id: imageIdInput.value,
      value: valueInput.value
    })
  })
    .then(async (response) => {
      const data = await response.json();
      if (!response.ok) throw data;
      return data;
    })
    .then((data) => {
      const average = document.getElementById("average-rating");
      if (average) average.textContent = data.average;

      updateRatingsTable(data);

      if (result) {
        result.textContent = `${form.dataset.successMessage}: ${data.average}`;
        result.classList.remove("error");
      }
    })
    .catch((data) => {
      if (result) {
        const errors = data.errors ? data.errors.join(", ") : form.dataset.errorMessage;
        result.textContent = errors;
        result.classList.add("error");
      }
    });
});

function updateRatingsTable(data) {
  const body = document.getElementById("ratings-table-body");
  if (!body) return;

  document.getElementById("ratings-empty-row")?.remove();

  let row = body.querySelector(`[data-user-id="${data.user_id}"]`);

  if (!row) {
    row = document.createElement("tr");
    row.dataset.userId = data.user_id;
    row.innerHTML = "<td></td><td></td>";
    body.appendChild(row);
  }

  row.children[0].textContent = data.user_email;
  row.children[1].textContent = data.value;
}
