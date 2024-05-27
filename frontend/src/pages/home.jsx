import { useGlobalState } from "../hooks";

function Home() {
	const { state, action } = useGlobalState();

	const { movies } = state;

	return <div>
        
    </div>;
}

export default Home;
