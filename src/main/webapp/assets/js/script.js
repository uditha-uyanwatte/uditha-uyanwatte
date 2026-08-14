// ======================
// Gallery Lightbox
// ======================

const galleryCards = document.querySelectorAll(".gallery-card");
const lightbox = document.getElementById("lightbox");
const lightboxImg = document.getElementById("lightboxImg");
const closeLightbox = document.getElementById("closeLightbox");

if (galleryCards.length > 0 && lightbox && lightboxImg && closeLightbox) {

    galleryCards.forEach(card => {

        card.addEventListener("click", () => {

            lightboxImg.src = card.querySelector("img").src;

            lightbox.style.display = "flex";

            document.body.style.overflow = "hidden";

        });

    });

    closeLightbox.addEventListener("click", () => {

        lightbox.style.display = "none";

        document.body.style.overflow = "auto";

    });

    lightbox.addEventListener("click", (e) => {

        if (e.target === lightbox) {

            lightbox.style.display = "none";

            document.body.style.overflow = "auto";

        }

    });

}



document.addEventListener("DOMContentLoaded", function () {

    /* =========================
       SMOOTH SCROLLING
    ========================= */

    document.querySelectorAll('a[href^="#"]').forEach(link => {

        link.addEventListener("click", function (e) {

            const targetId = this.getAttribute("href");

            if (!targetId || targetId === "#") {
                return;
            }

            const target = document.querySelector(targetId);

            if (target) {

                e.preventDefault();

                const navbarHeight = document.querySelector(".navbar")
                    ? document.querySelector(".navbar").offsetHeight
                    : 0;

                const targetPosition =
                    target.getBoundingClientRect().top +
                    window.pageYOffset -
                    navbarHeight;

                window.scrollTo({
                    top: targetPosition,
                    behavior: "smooth"
                });

            }

        });

    });


    /* =========================
       BACK TO TOP
    ========================= */

    const backToTop = document.querySelector(".back-to-top");

    if (backToTop) {

        window.addEventListener("scroll", function () {

            if (window.scrollY > 500) {

                backToTop.classList.add("show");

            } else {

                backToTop.classList.remove("show");

            }

        });

        backToTop.addEventListener("click", function (e) {

            e.preventDefault();

            window.scrollTo({
                top: 0,
                behavior: "smooth"
            });

        });

    }


    /* =========================
       MOBILE NAVBAR
    ========================= */

    const navLinks =
        document.querySelectorAll(".navbar .nav-link");

    const navbarCollapse =
        document.querySelector(".navbar-collapse");

    navLinks.forEach(link => {

        link.addEventListener("click", function () {

            if (
                window.innerWidth < 992 &&
                navbarCollapse &&
                navbarCollapse.classList.contains("show")
            ) {

                const bsCollapse =
                    bootstrap.Collapse.getInstance(navbarCollapse);

                if (bsCollapse) {
                    bsCollapse.hide();
                }

            }

        });

    });


    /* =========================
       ACTIVE NAVIGATION
    ========================= */

    const sections =
        document.querySelectorAll("section[id]");

    window.addEventListener("scroll", function () {

        let currentSection = "";

        sections.forEach(section => {

            const sectionTop =
                section.offsetTop - 180;

            const sectionHeight =
                section.offsetHeight;

            if (
                window.scrollY >= sectionTop &&
                window.scrollY < sectionTop + sectionHeight
            ) {

                currentSection = section.getAttribute("id");

            }

        });

        navLinks.forEach(link => {

            link.classList.remove("active");

            const href =
                link.getAttribute("href");

            if (
                currentSection &&
                href === "#" + currentSection
            ) {

                link.classList.add("active");

            }

        });

    });

});
