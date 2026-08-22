console.log("Hero JS Loaded");

import * as THREE from "https://cdn.jsdelivr.net/npm/three@0.169.0/build/three.module.js";
import { GLTFLoader } from "https://cdn.jsdelivr.net/npm/three@0.169.0/examples/jsm/loaders/GLTFLoader.js";

const container = document.getElementById("hero3d");

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(
45,
container.clientWidth/container.clientHeight,
0.1,
1000
);

camera.position.set(0,0,8);

const renderer = new THREE.WebGLRenderer({
antialias:true,





alpha:true
});

renderer.setSize(
container.clientWidth,
container.clientHeight
);

renderer.setPixelRatio(window.devicePixelRatio);

container.appendChild(renderer.domElement);
const ambient = new THREE.AmbientLight(0xffffff,4);
scene.add(ambient);

const light = new THREE.DirectionalLight(0xffffff,5);
light.position.set(5,8,5);
scene.add(light);

const loader = new GLTFLoader();

loader.load(

"assets/models/tooth.glb",

function(gltf){

const model = gltf.scene;

// Center model
const box = new THREE.Box3().setFromObject(model);
const center = box.getCenter(new THREE.Vector3());

model.position.sub(center);

// Scale
model.scale.set(0.8,0.8,0.8);

scene.add(model);

function animate(){

requestAnimationFrame(animate);

model.rotation.y += 0.01;

renderer.render(scene,camera);

}

animate();

}

);
window.addEventListener("resize",()=>{

camera.aspect=container.clientWidth/container.clientHeight;

camera.updateProjectionMatrix();

renderer.setSize(container.clientWidth,container.clientHeight);

});

const visual = document.querySelector(".hero-visual");

if (visual) {

    let rotation = 0;

    function animateHero() {

        rotation += 0.15;

        const tooth =
            document.querySelector(".hero-tooth");

        if (tooth) {

            tooth.style.transform =
                `translateY(${Math.sin(rotation / 18) * 8}px)
                 rotate(${Math.sin(rotation / 35) * 2}deg)`;

        }

        requestAnimationFrame(animateHero);

    }

    animateHero();
}