// @ts-check
// `@type` JSDoc annotations allow editor autocompletion and type checking
// (when paired with `@ts-check`).
// There are various equivalent ways to declare your Docusaurus config.
// See: https://docusaurus.io/docs/api/docusaurus-config

import {themes as prismThemes} from 'prism-react-renderer';

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'ASP',
  tagline: 'Simplified, Predictable and Powerful State Management for Flutter.',
  favicon: 'img/favicon.ico',

  // Set the production url of your site here
  url: 'https://asp.flutterando.com.br',
  // Set the /<baseUrl>/ pathname under which your site is served
  // For GitHub pages deployment, it is often '/<projectName>/'
  baseUrl: '/',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'Flutterando', // Usually your GitHub org/user name.
  projectName: 'asp', // Usually your repo name.

  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',

  // Even if you don't use internationalization, you can use this field to set
  // useful metadata like html lang. For example, if your site is Chinese, you
  // may want to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      'classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      ({
        docs: {
          sidebarPath: './sidebars.js',
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          editUrl:
            'https://github.com/Flutterando/asp/tree/main/doc',
        },
        theme: {
          customCss: './src/css/custom.css',
        },
      }),
    ],
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      // Replace with your project's social card
      image: 'img/docusaurus-social-card.jpg',
      navbar: {
        title: 'ASP',
        logo: {
          alt: 'Atomic State Pattern',
          src: 'img/logo.svg',
        },
        items: [
          {
            type: 'docSidebar',
            sidebarId: 'tutorialSidebar',
            position: 'left',
            label: 'Docs',
          },
          {
            href: 'https://discord.flutterando.com.br',
            position: 'left',
            label: 'Discord',
          },
          {
            href: 'https://github.com/Flutterando/asp',
            label: 'GitHub',
            position: 'right',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Docs',
            items: [
              {
                label: 'Introduction',
                to: '/docs/category/introduction',
              },
              {
                label: 'Basic Usage',
                to: '/docs/category/basic-usage',
              },
              {
                label: 'Extras',
                to: '/docs/category/extras',
              },
              {
                label: 'Examples',
                to: '/docs/category/examples',
              },
            ],
          },
          {
            title: 'Community',
            items: [
              {
                label: 'Discord',
                href: 'https://discord.flutterando.com.br',
              },
              {
                label: 'Telegram',
                href: 'https://telegram.flutterando.com.br',
              },
              {
                label: 'Instagram',
                href: 'https://instragram.flutterando.com.br',
              },
              {
                label: 'Twitter',
                href: 'https://twitter.flutterando.com.br',
              }
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'GitHub',
                href: 'https://github.com/Flutterando',
              },
              {
                label: 'YouTube',
                href: 'https://youtube.flutterando.com.br',
              },
              {
                label: 'LinkedIn',
                href: 'https://linkedin.flutterando.com.br',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} Flutterando, Inc. Built with Docusaurus.`,
      },
      prism: {
        theme: prismThemes.github,
        darkTheme: prismThemes.dracula,
        additionalLanguages: ['dart'],
      },
    }),
};

export default config;
