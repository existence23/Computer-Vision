% Your code here.
img = imread('../images/01_list.jpg');
[lines, ~] = findLetters(img);
figure;
imshow(img);
hold on
for i = 1 : length(lines)
    tmp = lines{i};
    for j = 1 : size(tmp, 1)
        pos = tmp(j, :);
        pos(3) = pos(3) - pos(1);
        pos(4) = pos(4) - pos(2);
        rectangle('Position', pos, 'EdgeColor', 'g', 'LineWidth', 1);
    end
end
hold off

img = imread('../images/02_letters.jpg');
[lines, ~] = findLetters(img);
figure;
imshow(img);
hold on
for i = 1 : length(lines)
    tmp = lines{i};
    for j = 1 : size(tmp, 1)
        pos = tmp(j, :);
        pos(3) = pos(3) - pos(1);
        pos(4) = pos(4) - pos(2);
        rectangle('Position', pos, 'EdgeColor', 'g', 'LineWidth', 1);
    end
end
hold off

img = imread('../images/03_haiku.jpg');
[lines, ~] = findLetters(img);
figure;
imshow(img);
hold on
for i = 1 : length(lines)
    tmp = lines{i};
    for j = 1 : size(tmp, 1)
        pos = tmp(j, :);
        pos(3) = pos(3) - pos(1);
        pos(4) = pos(4) - pos(2);
        rectangle('Position', pos, 'EdgeColor', 'g', 'LineWidth', 1);
    end
end
hold off

img = imread('../images/04_deep.jpg');
[lines, ~] = findLetters(img);
figure;
imshow(img);
hold on
for i = 1 : length(lines)
    tmp = lines{i};
    for j = 1 : size(tmp, 1)
        pos = tmp(j, :);
        pos(3) = pos(3) - pos(1);
        pos(4) = pos(4) - pos(2);
        rectangle('Position', pos, 'EdgeColor', 'g', 'LineWidth', 1);
    end
end
hold off


