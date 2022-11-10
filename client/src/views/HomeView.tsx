const HomeView = () => {
  return (
    <div
      style={{
        color: 'white',
        width: '100%',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
      }}
    >
      <h1>WELCOME TO KOMO PIZZA!</h1>
      <span>
        For orders call Ariel at -{' '}
        <a
          style={{
            color: 'red',
            cursor: 'pointer !important',
          }}
          href='tel:0509012770'
        >
          0509012770
        </a>
      </span>
      <code>* online orders coming soon</code>
    </div>
  );
};

export default HomeView;
