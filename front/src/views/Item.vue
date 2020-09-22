<template>
  <div>
    <v-row justify="center">
      <v-col cols="12">
        <file-input-modal
          :accepted-file-format="'image/jpeg, image/png'"
          :file-rules="validation().uploadedFile()"
          :is-open="isOpenModal"
          :uploading="processingUploadingImages"
          :title="'画像'"
          @change="uploadItemImages"
          @openModal="toggleUploadImagesModal"
        />
      </v-col>
    </v-row>
    <v-row>
      <v-col v-show="loadingImages" cols="12">
        <v-progress-linear
          indeterminate
          color="primary"
        ></v-progress-linear>
      </v-col>
      <v-col v-show="!loadingImages" cols="12">
        <v-row
          style="min-height: 228px;"
          justify="center"
          align-content="start"
        >
        <v-col v-for="(image, index) in itemImages" :key="index" cols="3">
          <v-card height="90" width="90">
            <v-img
              :src="image.url"
            ></v-img>
          </v-card>
        </v-col>
        </v-row>
      </v-col>
    </v-row>
  </div>
</template>

<script lang='ts'>
import Vue from 'vue'
import axios from 'axios'
import { AxiosResponse, AxiosError } from 'axios';
import { FileInputModal } from '../components/base';

interface ItemImage{
url: string;
lastModified: string;
}
interface Data
{
  isOpenModal: boolean;
  processingUploadingImages: boolean;
  loadingImages: boolean;
  itemImages: ItemImage[];
}
export default Vue.extend({
  name: 'Item',
  components: {
    FileInputModal
  },
  data(): Data{
    return{
      isOpenModal: false,
      processingUploadingImages: false,
      loadingImages: false,
      itemImages: []
    }
  },
  computed: {
  },
  mounted(){
    this.loadItemImages()
  },
  methods: {
    validation(){
      return {
        uploadedFile() {
          return [
            (v: any) =>
              !v.length ||
              v.every((image: File) => image.size < 10000000) ||
              '画像は10MB以下にしてください',
          ];
        },
      }
    },
    uploadItemImages(files: File[]) {
      const formData = new FormData();
      files.forEach(image => {
        formData.append('item_images[]', image);
      });
      this.uploadImages(formData)
    },
    toggleUploadImagesModal(isOpen: boolean){
      this.isOpenModal = isOpen
    },
    async loadItemImages(){
      this.loadingImages = true;
      axios.get('http://localhost:3000/api/v1/item_images').then((res: AxiosResponse)=>{
        this.itemImages =  res.data
      })
      this.loadingImages = false;
    },
    async uploadImages(
      images: any[]
    ): Promise<void> {
      this.processingUploadingImages = true;

    const url =
      'http://localhost:3000/api/v1/item_images/upload';
    const headers = { 'Content-Type': 'multipart/form-data' };

    await axios({
      method: 'post',
      url: url,
      data: images,
      headers: headers,
    })
      .then(() => {
        console.log('SUCCESS')
      })
      .catch((error: AxiosError) => {
        console.log('ERROR', error)
      })
      this.processingUploadingImages = true;
      this.isOpenModal = false;
      this.loadItemImages();
    },
  },

})
</script>

<style>

</style>
