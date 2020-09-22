<template>
  <div>
    <v-btn small @click="openModal">{{ title }}アップロード</v-btn>
    <v-dialog :value="isOpen" max-width="600" @click:outside="closeModal">
      <v-card>
        <v-card-title>{{ title }}をアップロード</v-card-title>
        <v-progress-linear
          v-show="uploading"
          indeterminate
          color="primary"
        ></v-progress-linear>
        <v-form>
          <v-file-input
            :value="files"
            chips
            label="ファイルを選択"
            multiple
            :accept="acceptedFileFormat"
            :rules="fileRules"
            @change="change"
          />
        </v-form>
        <v-card-actions>
          <div class="text-center">
            <v-btn class="mb-2" small depressed @click="closeModal"
              >キャンセル</v-btn
            >
          </div>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script lang="ts">
import Vue, { PropType } from 'vue';
interface Data {
  files: File[];
}
export default Vue.extend({
  props: {
    acceptedFileFormat: {
      type: String,
      default: '',
    },
    fileRules: {
      type: [],
      default: () => [],
    },
    isOpen: {
      type: Boolean,
      default: false,
    },
    uploading: {
      type: Boolean,
      required: true,
    },
    title: {
      type: String,
      default: 'ファイル',
    },
  },
  data: (): Data => {
    return {
      files: [],
    };
  },
  watch: {
    isOpen(value) {
      if (!value) {
        this.files = [];
      }
    },
  },
  methods: {
    change(files: File[]) {
      if (files.length > 0) {
        this.$emit('change', files);
      }
    },
    openModal() {
      this.$emit('openModal', true);
    },
    closeModal() {
      this.$emit('openModal', false);
    },
  },
});
</script>

<style></style>
