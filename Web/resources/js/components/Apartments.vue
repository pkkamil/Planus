<template>
    <article class="apartments" id="apartments">
            <h2 class="article-title">Mieszkania</h2>
            <h4 class="article-subtitle">Przejrzyj dostępne, przyjazne zakątki</h4>
            <section class="list-apartments">
                <section class="single-apartment" v-for="apartment in apartments" :key="apartment.id">
                    <a :href="'/mieszkanie/' + apartment.id_apartment">
                        <img :src="apartment.image" :alt="apartment.name" class="lazy">
                        <section class="layer">
                            <h3>{{ apartment.price }} zł</h3>
                            <h4>{{ apartment.name }}</h4>
                            <h5>{{ apartment.localization }}</h5>
                        </section>
                    </a>
                </section>
            </section>
            <button v-show="moreExists" v-on:click="loadMore">Zobacz więcej</button>
    </article>
</template>

<script>
    export default {
        data() {
            return {
                apartments: [],
                apartment: {
                    id: '',
                    image: '',
                    price: '',
                    name: '',
                    localization: ''
                },
                apartment_id: '',
                nextPage: 1,
                moreExists: false,
            };
        },

        created() {
            this.fetchApartments(10);
        },

        methods: {
            fetchApartments(items) {
                fetch('api/apartments/paginate/10')
                    .then(res => res.json())
                    .then(res => {
                        this.apartments = res.data;
                        if (res.meta.current_page < res.meta.last_page)
                            this.moreExists = true;
                            this.nextPage = res.meta.current_page + 1;
                    })
            },
            loadMore(nextPage) {
                fetch('api/apartments/paginate/10?page=' + this.nextPage)
                    .then(res => res.json())
                    .then(res => {
                        if (res.meta.current_page < res.meta.last_page) {
                            this.moreExists = true;
                            this.nextPage = res.meta.current_page + 1;
                        } else {
                            this.moreExists = false;
                        }

                        res.data.forEach(data => {
                            this.apartments.push(data);
                        })
                    })
            }
        }
    }
</script>
