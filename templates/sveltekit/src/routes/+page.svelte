<script lang="ts">
  let count = $state(0);
</script>

<main>
  <h1>SvelteKit Starter</h1>
  <p>Counter: {count}</p>
  <button onclick={() => count++}>Increment</button>
</main>
