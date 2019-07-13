import 'cookieconsent';

const languagePath = window.location.href.split('#')[0];
const section = languagePath.split('/')[3];

if (section === 'en') {
    window.cookieconsent.initialise({
        palette: {
            popup: {
                background: '#333',
                text: '#fff',
            },
            button: {
                background: '#000000',
                text: '#ffffff',
            },
        },
        content: {
            message: 'We use cookies to optimize our website.',
            dismiss: 'OK',
            link: 'Find out more',
            href: '/en/datenschutz',
        },
    });
} else {
    window.cookieconsent.initialise({
        palette: {
            popup: {
                background: '#333',
                text: '#fff',
            },
            button: {
                background: '#000000',
                text: '#ffffff',
            },
        },
        content: {
            message: 'Wir verwenden Cookies zur Optimierung unserer Website.',
            dismiss: 'OK',
            link: 'Mehr erfahren',
            href: '/datenschutz',
        },
    });
}
