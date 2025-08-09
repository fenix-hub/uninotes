<template>
  <div class="grid lg:grid-cols-3 gap-8">
    <!-- Main Content Area -->
    <div class="lg:col-span-2 space-y-6">
      <!-- Note Header Skeleton -->
      <div class="bg-white p-6 sketch-border shadow-lg animate-pulse">
        <div class="flex items-start justify-between mb-4">
          <div class="flex items-center gap-3">
            <div class="w-12 h-12 bg-gray-200 rounded"></div>
            <div>
              <div class="h-8 bg-gray-200 rounded w-64 mb-2"></div>
              <div class="h-5 bg-gray-200 rounded w-32"></div>
            </div>
          </div>
          <div class="flex items-center gap-2">
            <div class="h-6 bg-gray-200 rounded w-16"></div>
          </div>
        </div>

        <!-- Course Info Skeleton -->
        <div class="mb-4 p-4 bg-blue-50 rounded-lg">
          <div class="grid md:grid-cols-2 gap-4">
            <div class="h-4 bg-gray-200 rounded"></div>
            <div class="h-4 bg-gray-200 rounded"></div>
          </div>
        </div>

        <!-- Tags Skeleton -->
        <div class="mb-4 flex gap-2">
          <div class="h-6 bg-gray-200 rounded-full w-16"></div>
          <div class="h-6 bg-gray-200 rounded-full w-20"></div>
          <div class="h-6 bg-gray-200 rounded-full w-14"></div>
        </div>

        <!-- Meta Info Skeleton -->
        <div class="flex justify-between border-t pt-4">
          <div class="h-4 bg-gray-200 rounded w-32"></div>
          <div class="h-4 bg-gray-200 rounded w-32"></div>
        </div>
      </div>

      <!-- Content Skeleton -->
      <div class="bg-white p-6 sketch-border shadow-lg animate-pulse">
        <div class="h-6 bg-gray-200 rounded w-48 mb-4"></div>
        <div class="w-full h-96 bg-gray-200 rounded"></div>
      </div>
    </div>

    <!-- Sidebar Skeleton -->
    <div class="space-y-6">
      <!-- Files List Skeleton -->
      <div class="bg-white p-6 sketch-border shadow-lg animate-pulse">
        <div class="h-6 bg-gray-200 rounded w-32 mb-4"></div>
        <div class="space-y-3">
          <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
            <div class="flex items-center gap-3">
              <div class="w-8 h-8 bg-gray-200 rounded"></div>
              <div>
                <div class="h-4 bg-gray-200 rounded w-24 mb-1"></div>
                <div class="h-3 bg-gray-200 rounded w-16"></div>
              </div>
            </div>
            <div class="h-6 bg-gray-200 rounded w-16"></div>
          </div>
        </div>
      </div>

      <!-- Actions Skeleton -->
      <div class="bg-white p-6 sketch-border shadow-lg animate-pulse">
        <div class="h-6 bg-gray-200 rounded w-28 mb-4"></div>
        <div class="space-y-3">
          <div class="h-10 bg-gray-200 rounded"></div>
          <div class="h-10 bg-gray-200 rounded"></div>
          <div class="h-10 bg-gray-200 rounded"></div>
        </div>
      </div>

      <!-- Stats Skeleton -->
      <div class="bg-white p-6 sketch-border shadow-lg animate-pulse">
        <div class="h-6 bg-gray-200 rounded w-24 mb-4"></div>
        <div class="space-y-3">
          <div class="flex justify-between">
            <div class="h-4 bg-gray-200 rounded w-20"></div>
            <div class="h-4 bg-gray-200 rounded w-8"></div>
          </div>
          <div class="flex justify-between">
            <div class="h-4 bg-gray-200 rounded w-16"></div>
            <div class="h-4 bg-gray-200 rounded w-8"></div>
          </div>
          <div class="flex justify-between">
            <div class="h-4 bg-gray-200 rounded w-24"></div>
            <div class="h-4 bg-gray-200 rounded w-12"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.sketch-border {
  border: 2px solid #374151;
  border-radius: 8px;
  position: relative;
}

.sketch-border::before {
  content: '';
  position: absolute;
  top: -2px;
  left: -2px;
  right: -2px;
  bottom: -2px;
  border: 2px solid #374151;
  border-radius: 10px;
  transform: rotate(0.5deg);
  z-index: -1;
}
</style>
