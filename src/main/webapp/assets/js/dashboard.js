// Revenue Chart

const ctx = document.getElementById('revenueChart');

if (ctx) {

    new Chart(ctx, {

        type: 'line',

        data: {

            labels: [
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec'
            ],

            datasets: [

                {

                    label: 'Monthly Revenue (Rs.)',

                    data: [
                        45000,
                        52000,
                        61000,
                        58000,
                        70000,
                        82000,
                        91000,
                        85000,
                        98000,
                        110000,
                        120000,
                        135000
                    ],

                    borderWidth: 3,

                    fill: true,

                    tension: 0.4,

                    borderColor: '#2d6bff',

                    backgroundColor: 'rgba(45,107,255,0.15)'

                }

            ]

        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            plugins: {

                legend: {

                    display: true

                }

            },

            scales: {

                y: {

                    beginAtZero: true

                }

            }

        }

    });

}