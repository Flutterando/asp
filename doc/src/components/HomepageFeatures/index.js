import clsx from 'clsx';
import Heading from '@theme/Heading';
import styles from './styles.module.css';

const FeatureList = [
  {
    title: 'Simple!',
    Svg: require('@site/static/img/undraw_team_up_re_84ok.svg').default,
    description: (
      <>
        Create a global state in a simple and intuitive way and use it anywhere
        of your application in a simple and safe way.
      </>
    ),
  },
  {
    title: 'Predictable!',
    Svg: require('@site/static/img/undraw_undraw_undraw_undraw_undraw_website_o7n3_bucy_30uo_-1-_d6br_0qfo.svg').default,
    description: (
      <>
        Everything happens where it should happen in a transparent and predictable way.
        There's no magic, there's logic.
      </>
    ),
  },
  {
    title: 'Exclusive for Flutter!',
    Svg: require('@site/static/img/undraw_engineering_team_a7n2.svg').default,
    description: (
      <>
        Everything here was developed with Flutter in mind. Who said state management
        can't it be fun?
      </>
    ),
  },
];

function Feature({Svg, title, description}) {
  return (
    <div className={clsx('col col--4')}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <Heading as="h3">{title}</Heading>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures() {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
