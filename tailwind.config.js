// import preset from './vendor/filament/support/tailwind.config.preset';
import * as defaultTheme from 'tailwindcss/defaultTheme';
console.log(defaultTheme.colors)

export default {
    // presets: [preset],
    darkMode: 'selector',
    theme: {
        container: {
            center: true,
        },
        extend: {
            fontFamily: {
                sans: ['Inter', ...defaultTheme.fontFamily.sans],
            },
        },
    },
    variants: {
        extend: {
            backgroundColor: ['active'],
        }
    },
    content: [
        './app/**/*.php',
        './resources/**/*.html',
        './resources/**/*.js',
        './resources/**/*.jsx',
        './resources/**/*.ts',
        './resources/**/*.tsx',
        './resources/**/*.php',
        './vendor/filament/**/*.blade.php',
    ],
    plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/typography'),
	],
}
