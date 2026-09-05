<script lang="ts">
  let { data, children } = $props();
</script>

<header>
  <h1>Welcome to {data.title}</h1>
</header>

<main>
  {@render children?.()}
</main>
