/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        obsidian: '#09090b',
        midnight: '#10131c',
        sapphire: '#246bff',
        cyanGlow: '#71d8ff',
        amberGlow: '#d6a55d',
        ivory: '#f5efe6',
        mist: '#b9c2d0',
      },
      fontFamily: {
        display: ['"Cormorant Garamond"', 'serif'],
        sans: ['"Manrope"', 'sans-serif'],
      },
      boxShadow: {
        glow: '0 0 0 1px rgba(113, 216, 255, 0.14), 0 24px 80px rgba(8, 13, 32, 0.45)',
      },
      backgroundImage: {
        'hero-radial':
          'radial-gradient(circle at top, rgba(36, 107, 255, 0.25), transparent 38%), radial-gradient(circle at 85% 20%, rgba(214, 165, 93, 0.18), transparent 22%), linear-gradient(180deg, #09090b 0%, #0f1320 52%, #09090b 100%)',
      },
    },
  },
  plugins: [],
};
