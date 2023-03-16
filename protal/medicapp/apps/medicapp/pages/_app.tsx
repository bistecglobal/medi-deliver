import { AppProps } from 'next/app';
import Head from 'next/head';
import './styles.css';
import RootLayout from './layout';
import DashBoard from '../components/dash-board/dash-board';

// function CustomApp({ Component, pageProps }: AppProps) {
//   return (
//     <>
//       <Head>
//         <title>Welcome to medicapp!</title>
//       </Head>
//       <main className="app">
//         <Component {...pageProps} />
        
//       </main>
//     </>
//   );
// }

// export default CustomApp;

export default function CustomApp({ Component, pageProps }) {
  // Use the layout defined at the page level, if available
  const getLayout = Component.getLayout || ((page) => <DashBoard>{page}</DashBoard>)

  return getLayout(<Component {...pageProps} />)
}

