import styles from './mainpage.module.css';

/* eslint-disable-next-line */
export interface MainpageProps {}

export function Mainpage(props: MainpageProps) {
  return (
    <div className={styles['container']}>
      <h1>Welcome to Mainpage!</h1>
    </div>
  );
}

export default Mainpage;
