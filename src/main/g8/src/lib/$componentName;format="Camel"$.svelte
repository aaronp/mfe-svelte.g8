<svelte:options tag="$componentName;format="lower,hyphen"$" />

<script lang="ts">
  let count: number = 0
  const increment = () => {
    count += 1
  }
</script>

<h2>$name$</h2>
<button on:click={increment}>
  clicks: {count}
</button>
