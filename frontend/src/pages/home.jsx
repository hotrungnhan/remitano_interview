import { useGlobalState } from "../hooks";
import { YouTube } from "react-youtube-lazyload";
import "react-youtube-lazyload/dist/index.css";

function HomePage() {
	const { state, action } = useGlobalState();
	const { notification } = action;
	const { movies } = state;

	return (
		<div className="h-full w-full mx-auto container py-4">
			<div className=" w-full flex flex-col justify-items-start place-items-center gap-4">
				{movies?.map((movie, index) => {
					return (
						<div
							key={index}
							className="border-2 border-blue-500 w-full rounded-md min-w-48 flex flex-row justify-between"
						>
							<YouTube
								videoId={movie.youtube_id}
								width={700}
								height={315}
								privacy={true} // Privacy Enhanced Mode (optional) - default: false
								className="max-w-full"
							/>

							<div className="flex flex-col px-4 py-4 max-w-[50%]">
								<div className="flex flex-row gap-2 justify-between">
									<div className="flex flex-col ">
										<h1 className="text-xl text-red-500 font-medium">
											{movie?.title}
										</h1>
										<p>
											<a className="font-medium">Shared By: </a>
											<a className="font-light ">{movie?.uploader?.email}</a>
										</p>
										<div className="flex flex-row gap-4">
											<div>
												{movie?.metadata?.upvote} <button>👍</button>
											</div>
											<div>
												{movie?.metadata?.downvote} <button>👎</button>
											</div>
										</div>
									</div>
									<div className="text-6xl text-red-500 text-nowrap">
										<button
											onClick={() =>
												notification.fire({
													title: "👍",
													text: "Not Implemented !!",
													icon: "success",
												})
											}
										>
											👍
										</button>
										<button
											onClick={() =>
												notification.fire({
													title: "👎",
													text: "Not Implemented !!",
													icon: "success",
												})
											}
										>
											👎
										</button>
									</div>
								</div>
								<div>
									<a className="font-medium">Description: </a>
									<p className="font-light italic line-clamp-6">
										{movie?.description}
									</p>
								</div>
							</div>
						</div>
					);
				})}
			</div>
		</div>
	);
}

export default HomePage;
