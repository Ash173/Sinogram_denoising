clc
close all
clear

save_path = 'saved_sinograms2.h5';

noisy_sinogram = h5read(save_path, '/noisy_sinogram');
clean_sinogram = h5read(save_path, '/clean_sinogram');
processed_sinogram = h5read(save_path, '/processed_sinogram');

ig_big = image_geom('nx', 512, 'fov', 35, 'down', 1);
sg = sino_geom('ge1', 'units', 'cm', 'strip_width', 'd', 'down', 1);
geom = fbp2(sg, ig_big);

recon_noisy = fbp2(noisy_sinogram, geom,'window', 'ramp');
recon_clean = fbp2(clean_sinogram, geom,'window', 'ramp');
recon_processed = fbp2(processed_sinogram, geom,'window', 'ramp');
%%
figure;
subplot(2,3,1); imshow(recon_noisy*3500,[]); colormap("gray"); title("Noisy image"); axis image; colorbar; caxis([884 1284]);
subplot(2,3,2); imshow(recon_clean*3500,[]); colormap("gray"); title("Clean image"); axis image; colorbar; caxis([884 1284]);
subplot(2,3,3); imshow(recon_processed*3500,[]); colormap("gray"); title("Model processed image"); axis image; colorbar; caxis([884 1284]);
subplot(2,3,4); imshow(abs(recon_noisy*3500-recon_clean*3500),[]); colormap("gray"); title("Diff b\w Noisy and clean image"); axis image; colorbar; caxis([0 50]);
subplot(2,3,5); imshow(abs(recon_processed*3500-recon_clean*3500),[]); colormap("gray"); title("Diff b\w processed and clean image"); axis image; colorbar; caxis([0 50]);
% subplot(2,3,6); imagesc(recon_processed); colormap("gray"); title("Model processed image"); axis image; colorbar;




