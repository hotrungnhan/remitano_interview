import { useGlobalState } from "../hooks";
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
							<iframe
								width="1000"
								height="315"
								className="max-w-[50%]"
								src={movie.embedded_url}
								title="YouTube video player"
								allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
								referrerPolicy="strict-origin-when-cross-origin"
							></iframe>

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
